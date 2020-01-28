require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe "validations" do
    it { should validate_presence_of :credit_card_number }
  end
  describe "relationships" do
    it { should belong_to :invoice }
  end
end
