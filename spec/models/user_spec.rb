require 'spec_helper'

RSpec.describe User, type: :model do
  it { should have_many :contents }
end
