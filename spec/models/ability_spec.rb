require 'spec_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:user) { FactoryGirl.build(:user) }

  context 'ability defined with user' do
    subject(:ability) { described_class.new(user) }

    context 'User' do
      it { should be_able_to(:manage, Content) }
      it { should be_able_to(:read, Content) }
    end

    context 'User is going to manage others resource' do
      let(:user_1) { FactoryGirl.create(:user) }
      let(:user_2) { FactoryGirl.create(:user) }
      let(:post_1) { FactoryGirl.create(:content, user: user_1) }
      let(:post_2) { FactoryGirl.create(:content, user: user_2) }

      subject(:ability) { described_class.new(user_1) }

      it { should be_able_to(:manage, post_1) }
      it { should_not be_able_to(:edit, post_2) }
      it { should_not be_able_to(:delete, post_2) }
      it { should_not be_able_to(:update, post_2) }
      it { should_not be_able_to(:manage, post_2) }
      it { should be_able_to(:show, post_2) }
    end
  end
end