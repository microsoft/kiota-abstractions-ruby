# frozen_string_literal: true

require_relative 'spec_helper'
require 'microsoft_kiota_abstractions'

module PrimitiveComposedModels
  class Simple
    include MicrosoftKiotaAbstractions::Parsable

    attr_accessor :email

    def get_field_deserializers = { 'email' => ->(n) { @email = n.get_string_value } }
    def serialize(writer) = writer.write_string_value('email', @email)
    def self.create_from_discriminator_value(_parse_node) = Simple.new
  end
end

RSpec.describe 'composed types with primitive members' do
  let(:writer) { MicrosoftKiotaSerializationJson::JsonSerializationWriter.new }

  describe 'write_object_value with a leading nil member' do
    it 'still serializes the remaining members' do
      obj = PrimitiveComposedModels::Simple.new
      obj.email = 'x@y.z'
      writer.write_object_value(nil, nil, obj)
      expect(writer.writer).to eq({ 'email' => 'x@y.z' })
    end
  end

  describe 'scalar values written with a nil key' do
    it 'serializes a string as the root of the document' do
      writer.write_string_value(nil, 'hello')
      expect(JSON.parse(writer.get_serialized_content)).to eq('hello')
    end

    it 'serializes a number as the root of the document' do
      writer.write_number_value(nil, 42)
      expect(JSON.parse(writer.get_serialized_content)).to eq(42)
    end

    it 'serializes false as the root of the document rather than raising' do
      expect { writer.write_boolean_value(nil, false) }.not_to raise_error
      expect(JSON.parse(writer.get_serialized_content)).to be(false)
    end
  end

  describe 'type-strict parse node getters' do
    def node_for(json) = MicrosoftKiotaSerializationJson::JsonParseNode.new(JSON.parse(json))

    it 'answers only for the matching type' do
      s = node_for('"hello"')
      expect(s.get_string_value).to eq('hello')
      expect(s.get_number_value).to be_nil
      expect(s.get_boolean_value).to be_nil
      expect(s.get_float_value).to be_nil
    end

    it 'does not coerce a number into a string' do
      n = node_for('42')
      expect(n.get_string_value).to be_nil
      expect(n.get_number_value).to eq(42)
    end

    it 'keeps a float out of the integer reader' do
      expect(node_for('1.5').get_number_value).to be_nil
      expect(node_for('1.5').get_float_value).to eq(1.5)
    end

    it 'reads a whole number through the float reader, since JSON omits the fraction' do
      expect(node_for('1').get_float_value).to eq(1.0)
    end

    it 'returns false for a false boolean rather than nil' do
      expect(node_for('false').get_boolean_value).to be(false)
    end

    it 'does not answer the boolean reader for a lookalike' do
      expect(node_for('"true"').get_boolean_value).to be_nil
      expect(node_for('1').get_boolean_value).to be_nil
    end

    it 'does not stringify a structure' do
      expect(node_for('{"a": 1}').get_string_value).to be_nil
    end
  end

  describe 'collections of primitive values' do
    def collection_for(json) = MicrosoftKiotaSerializationJson::JsonParseNode.new(JSON.parse(json))

    # The generator passes the boolean type as a plain string and every other type as a constant,
    # so both shapes have to reach the right reader.
    it 'reads booleans as booleans' do
      expect(collection_for('[true, false]').get_collection_of_primitive_values('boolean')).to eq([true, false])
    end

    it 'reads whole numbers as integers' do
      expect(collection_for('[1, 2]').get_collection_of_primitive_values(Integer)).to eq([1, 2])
    end

    it 'reads floats as floats' do
      expect(collection_for('[1.5, 2.5]').get_collection_of_primitive_values(Float)).to eq([1.5, 2.5])
    end

    it 'reads strings as strings' do
      expect(collection_for('["a", "b"]').get_collection_of_primitive_values(String)).to eq(%w[a b])
    end

    # an untyped array is generated as Object, so its values must survive rather than be forced
    # through the string reader
    it 'passes an untyped collection through unchanged' do
      expect(collection_for('[1, "a", true]').get_collection_of_primitive_values(Object)).to eq([1, 'a', true])
    end
  end
end
