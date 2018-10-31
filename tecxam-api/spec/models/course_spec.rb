require "spec_helper"

describe Course do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :description }
  it { is_expected.to respond_to :acronym }

  it { is_expected.to validate_length_of(:acronym).is_equal_to(6) }

  context "database" do
    it { is_expected.to have_db_index(:user_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:exams) }
    it { is_expected.to have_many(:questions).through(:exams) }
  end

  it "validates acronym length" do
    course = build :course, acronym: 'invalid'

    course.valid?

    expect(course).to be_invalid
    expect(course.errors[:acronym]).to eq ["is the wrong length (should be 6 characters)"]
  end
end
