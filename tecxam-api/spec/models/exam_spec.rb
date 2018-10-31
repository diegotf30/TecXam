require "spec_helper"

describe Exam do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :is_random }

  context "database" do
    it { is_expected.to have_db_index(:course_id) }
  end

  context "associations" do
    it { is_expected.to belong_to(:course) }
    it { is_expected.to have_and_belong_to_many(:questions) }
  end

  describe '#add_question' do
    it 'should add question to exam' do
      exam = create :exam
      question = create :question

      exam.add_question(question)

      expect(exam.questions.count).to eq(1)
      expect(exam.questions.first).to eq(question)
    end
  end

  describe '#remove_question' do
    it 'should remove question from exam' do
      exam = create :exam, :with_questions, number_of_questions: 3

      exam.remove_question(exam.questions.first)

      expect(exam.questions.count).to eq(2)
    end
  end
end
