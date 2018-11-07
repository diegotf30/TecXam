require "spec_helper"

describe Answer do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :variables }

  context "database" do
    it { is_expected.to have_db_index(:question_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:question) }
  end

  describe '#user' do
    it 'should return the question owner'  do
      question = create :question
      answer = create :answer, question: question

      expect(answer.user).to eq(question.user)
    end
  end
end