require "spec_helper"

describe Question do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :tags }

  context "database" do
    it { is_expected.to have_db_index(:user_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:answers) }
    it { is_expected.to have_and_belong_to_many(:exams) }
  end
end
