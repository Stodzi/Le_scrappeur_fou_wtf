# frozen_string_literal: true

require_relative '../lib/dark_trader'
describe 'retrievePriceCrypto method ' do
  it 'should return an array' do
    expect(retrievePriceCrypto).not_to nil
  end
end
