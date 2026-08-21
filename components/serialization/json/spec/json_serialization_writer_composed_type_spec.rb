# frozen_string_literal: true

require_relative 'spec_helper'
require 'microsoft_kiota_abstractions'

module TestModels
  class SimpleParsable
    include MicrosoftKiotaAbstractions::Parsable

    attr_accessor :name, :age

    def get_field_deserializers
      {
        'name' => ->(n) { @name = n.get_string_value },
        'age' => ->(n) { @age = n.get_number_value }
      }
    end

    def serialize(writer)
      writer.write_string_value('name', @name)
      writer.write_number_value('age', @age)
    end

    def self.create_from_discriminator_value(_parse_node)
      SimpleParsable.new
    end
  end

  class AnotherParsable
    include MicrosoftKiotaAbstractions::Parsable

    attr_accessor :email

    def get_field_deserializers
      { 'email' => ->(n) { @email = n.get_string_value } }
    end

    def serialize(writer)
      writer.write_string_value('email', @email)
    end

    def self.create_from_discriminator_value(_parse_node)
      AnotherParsable.new
    end
  end

  class UnionTypeWrapper
    include MicrosoftKiotaAbstractions::Parsable
    include MicrosoftKiotaAbstractions::ComposedTypeWrapper

    attr_accessor :simple, :another

    def get_field_deserializers
      return @simple.get_field_deserializers if @simple
      return @another.get_field_deserializers if @another

      {}
    end

    def serialize(writer)
      if @simple
        writer.write_object_value(nil, @simple)
      elsif @another
        writer.write_object_value(nil, @another)
      end
    end

    def self.create_from_discriminator_value(_parse_node)
      UnionTypeWrapper.new
    end
  end

  class IntersectionTypeWrapper
    include MicrosoftKiotaAbstractions::Parsable
    include MicrosoftKiotaAbstractions::ComposedTypeWrapper

    attr_accessor :simple, :another

    def get_field_deserializers
      MicrosoftKiotaAbstractions::ParseNodeHelper
        .merge_deserializers_for_intersection_wrapper(@simple, @another)
    end

    def serialize(writer)
      writer.write_object_value(nil, @simple, @another)
    end

    def self.create_from_discriminator_value(_parse_node)
      IntersectionTypeWrapper.new
    end
  end
end

RSpec.describe MicrosoftKiotaSerializationJson::JsonSerializationWriter do
  describe '#write_object_value' do
    it 'serializes a regular object with a key' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      obj = TestModels::SimpleParsable.new
      obj.name = 'Alice'
      obj.age = 30

      writer.write_object_value('person', obj)
      expect(writer.writer['person']).to eq({ 'name' => 'Alice', 'age' => 30 })
    end

    it 'serializes a regular object with additional values merged under a key' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      obj1 = TestModels::SimpleParsable.new
      obj1.name = 'Alice'
      obj1.age = 30
      obj2 = TestModels::AnotherParsable.new
      obj2.email = 'alice@example.com'

      writer.write_object_value('person', obj1, obj2)
      expect(writer.writer['person']).to eq({ 'name' => 'Alice', 'age' => 30, 'email' => 'alice@example.com' })
    end

    it 'skips nil additional values' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      obj = TestModels::SimpleParsable.new
      obj.name = 'Bob'
      obj.age = 22

      writer.write_object_value('person', obj, nil, nil)
      expect(writer.writer['person']).to eq({ 'name' => 'Bob', 'age' => 22 })
    end

    it 'returns nil when value is nil' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      result = writer.write_object_value('key', nil)
      expect(result).to be_nil
      expect(writer.writer).to eq({})
    end

    it 'serializes into self when key is nil for a non-composed type' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      obj = TestModels::SimpleParsable.new
      obj.name = 'Eve'
      obj.age = 40

      writer.write_object_value(nil, obj)
      expect(writer.writer).to eq({ 'name' => 'Eve', 'age' => 40 })
    end
  end

  describe '#write_object_value with union types' do
    it 'serializes the first branch of a union into the current writer' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      union = TestModels::UnionTypeWrapper.new
      inner = TestModels::SimpleParsable.new
      inner.name = 'Charlie'
      inner.age = 25
      union.simple = inner

      writer.write_object_value(nil, union)
      expect(writer.writer).to eq({ 'name' => 'Charlie', 'age' => 25 })
    end

    it 'serializes the second branch of a union into the current writer' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      union = TestModels::UnionTypeWrapper.new
      inner = TestModels::AnotherParsable.new
      inner.email = 'test@example.com'
      union.another = inner

      writer.write_object_value(nil, union)
      expect(writer.writer).to eq({ 'email' => 'test@example.com' })
    end

    it 'produces valid JSON for a union type' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      union = TestModels::UnionTypeWrapper.new
      inner = TestModels::SimpleParsable.new
      inner.name = 'Charlie'
      inner.age = 25
      union.simple = inner

      writer.write_object_value(nil, union)
      json = writer.get_serialized_content
      parsed = JSON.parse(json)
      expect(parsed).to eq({ 'name' => 'Charlie', 'age' => 25 })
    end
  end

  describe '#write_object_value with intersection types' do
    it 'merges all intersection members into the current writer' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      intersection = TestModels::IntersectionTypeWrapper.new
      obj1 = TestModels::SimpleParsable.new
      obj1.name = 'Dana'
      obj1.age = 28
      obj2 = TestModels::AnotherParsable.new
      obj2.email = 'dana@example.com'
      intersection.simple = obj1
      intersection.another = obj2

      writer.write_object_value(nil, intersection)
      expect(writer.writer).to eq({ 'name' => 'Dana', 'age' => 28, 'email' => 'dana@example.com' })
    end

    it 'produces valid JSON for an intersection type' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      intersection = TestModels::IntersectionTypeWrapper.new
      obj1 = TestModels::SimpleParsable.new
      obj1.name = 'Dana'
      obj1.age = 28
      obj2 = TestModels::AnotherParsable.new
      obj2.email = 'dana@example.com'
      intersection.simple = obj1
      intersection.another = obj2

      writer.write_object_value(nil, intersection)
      json = writer.get_serialized_content
      parsed = JSON.parse(json)
      expect(parsed).to eq({ 'name' => 'Dana', 'age' => 28, 'email' => 'dana@example.com' })
    end
  end

  describe '#write_collection_of_object_values' do
    it 'serializes a collection of objects under a key' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      obj1 = TestModels::SimpleParsable.new
      obj1.name = 'Alice'
      obj1.age = 30
      obj2 = TestModels::SimpleParsable.new
      obj2.name = 'Bob'
      obj2.age = 25

      writer.write_collection_of_object_values('people', [obj1, obj2])
      expect(writer.writer['people']).to eq([
                                              { 'name' => 'Alice', 'age' => 30 },
                                              { 'name' => 'Bob', 'age' => 25 }
                                            ])
    end

    it 'serializes into self when key is nil' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      obj1 = TestModels::SimpleParsable.new
      obj1.name = 'Alice'
      obj1.age = 30

      writer.write_collection_of_object_values(nil, [obj1])
      expect(writer.writer).to eq({ 'name' => 'Alice', 'age' => 30 })
    end

    it 'does not contaminate the parent writer' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      writer.write_string_value('top_level', 'value')
      obj = TestModels::SimpleParsable.new
      obj.name = 'Alice'
      obj.age = 30

      writer.write_collection_of_object_values('people', [obj])
      expect(writer.writer.keys).to contain_exactly('top_level', 'people')
    end

    it 'produces valid JSON with a collection' do
      writer = MicrosoftKiotaSerializationJson::JsonSerializationWriter.new
      obj1 = TestModels::SimpleParsable.new
      obj1.name = 'Alice'
      obj1.age = 30
      obj2 = TestModels::AnotherParsable.new
      obj2.email = 'bob@example.com'

      writer.write_collection_of_object_values('items', [obj1])
      writer.write_object_value('contact', obj2)
      json = writer.get_serialized_content
      parsed = JSON.parse(json)
      expect(parsed['items']).to eq([{ 'name' => 'Alice', 'age' => 30 }])
      expect(parsed['contact']).to eq({ 'email' => 'bob@example.com' })
    end
  end
end
