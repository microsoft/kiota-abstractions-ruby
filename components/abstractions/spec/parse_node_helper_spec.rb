# frozen_string_literal: true

require 'microsoft_kiota_abstractions'

RSpec.describe MicrosoftKiotaAbstractions::ComposedTypeWrapper do
  it 'can be included in a class as a marker module' do
    klass = Class.new { include MicrosoftKiotaAbstractions::ComposedTypeWrapper }
    instance = klass.new
    expect(instance).to be_a(MicrosoftKiotaAbstractions::ComposedTypeWrapper)
  end

  it 'is not present on classes that do not include it' do
    klass = Class.new
    instance = klass.new
    expect(instance).not_to be_a(MicrosoftKiotaAbstractions::ComposedTypeWrapper)
  end
end

RSpec.describe MicrosoftKiotaAbstractions::SerializationWriter do
  let(:writer_class) { Class.new { include MicrosoftKiotaAbstractions::SerializationWriter } }

  it 'raises NotImplementedError for write_object_value' do
    writer = writer_class.new
    expect { writer.write_object_value('key', Object.new) }.to raise_error(NotImplementedError)
  end

  it 'accepts variadic additional_values_to_merge in its signature' do
    writer = writer_class.new
    expect { writer.write_object_value('key', Object.new, Object.new, Object.new) }.to raise_error(NotImplementedError)
  end
end

RSpec.describe MicrosoftKiotaAbstractions::ParseNodeHelper do
  describe '.merge_deserializers_for_intersection_wrapper' do
    it 'returns an empty hash when no targets are provided' do
      result = described_class.merge_deserializers_for_intersection_wrapper
      expect(result).to eq({})
    end

    it 'skips nil targets' do
      result = described_class.merge_deserializers_for_intersection_wrapper(nil, nil)
      expect(result).to eq({})
    end

    it 'merges deserializers from a single target' do
      target = double('Parsable')
      allow(target).to receive(:get_field_deserializers).and_return({ 'name' => :name_handler, 'age' => :age_handler })

      result = described_class.merge_deserializers_for_intersection_wrapper(target)
      expect(result).to eq({ 'name' => :name_handler, 'age' => :age_handler })
    end

    it 'merges deserializers from multiple targets' do
      target1 = double('Parsable1')
      target2 = double('Parsable2')
      allow(target1).to receive(:get_field_deserializers).and_return({ 'name' => :name_handler })
      allow(target2).to receive(:get_field_deserializers).and_return({ 'email' => :email_handler })

      result = described_class.merge_deserializers_for_intersection_wrapper(target1, target2)
      expect(result).to eq({ 'name' => :name_handler, 'email' => :email_handler })
    end

    it 'later targets override earlier targets on key conflict' do
      target1 = double('Parsable1')
      target2 = double('Parsable2')
      allow(target1).to receive(:get_field_deserializers).and_return({ 'name' => :handler_v1 })
      allow(target2).to receive(:get_field_deserializers).and_return({ 'name' => :handler_v2 })

      result = described_class.merge_deserializers_for_intersection_wrapper(target1, target2)
      expect(result).to eq({ 'name' => :handler_v2 })
    end

    it 'skips nil targets mixed with valid targets' do
      target = double('Parsable')
      allow(target).to receive(:get_field_deserializers).and_return({ 'id' => :id_handler })

      result = described_class.merge_deserializers_for_intersection_wrapper(nil, target, nil)
      expect(result).to eq({ 'id' => :id_handler })
    end
  end
end
