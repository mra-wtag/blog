require 'spec_helper'

RSpec.describe Content, type: :model do
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }
  it { should belong_to :user }
end