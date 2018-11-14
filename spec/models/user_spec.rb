require "spec_helper"

describe User do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :email }
  it { is_expected.to respond_to :gender }

  it { is_expected.to validate_length_of(:name).is_at_most(50) }

  context "database" do
    it { is_expected.to have_db_index(:email) }
    it { is_expected.to have_db_index(:confirmation_token) }
    it { is_expected.to have_db_index(:reset_password_token) }
  end

  context "associations" do
    it { is_expected.to have_many(:courses) }
    it { is_expected.to have_many(:exams).through(:courses) }
    it { is_expected.to have_many(:questions) }
  end

  it "validates name length" do
    user = build :user, name: 'Brhadaranyakopanishadvivekachudamaniasdasdasd Error'

    user.valid?

    expect(user).to be_invalid
    expect(user.errors[:name]).to eq ["is too long (maximum is 50 characters)"]
  end

  it "validates email format" do
    user = build :user, email: "usernameinvalid.org"

    user.valid?

    expect(user).to be_invalid
    expect(user.errors[:email]).to eq ["is invalid"]
  end

  describe '#tags' do
    it 'should return unique question tags' do
      user = create :user
      create_list :question, 3, :with_tags, user: user

      expect(user.tags).to eq(['tag1', 'tag2', 'tag3'])
    end
  end
end
