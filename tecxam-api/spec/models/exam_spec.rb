require "spec_helper"

describe Exam do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :date }
  it { is_expected.to respond_to :time_limit }
  it { is_expected.to respond_to :description }
  it { is_expected.to respond_to :random_questions }

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

  describe '#user' do
    it 'should return the course owner' do
      course = create :course
      exam = create :exam, course: course

      expect(exam.user).to eq(course.user)
    end
  end

  describe '#clean_questions' do
    it 'removes all questions from exam' do
      exam = create :exam, :with_questions
      exam.clean_questions

      expect(exam.questions.count).to eq(0)
    end
  end

  describe '#export' do
    it 'exports exam to pdf' do
      exam = create :exam, :with_questions
      exam.export

      expect(File.file?('tmp/exam.pdf')).to eq(true)
    end
  end

  describe '#add_random_questions' do
    it 'adds questions with specified tags' do
      question = create :question, tags: ['amss']
      exam = create :exam, random_questions: { amss: 1 }

      expect(exam.questions.count).to eq(1)
      expect(exam.questions.first).to eq(question)
    end

    it 'removes existing questions if new options selected' do
      question = create :question, tags: ['amss']
      exam = create :exam, :with_questions, number_of_questions: 3
      exam.update(random_questions: { amss: 1 })

      expect(exam.questions.count).to eq(1)
      expect(exam.questions.first).to eq(question)
    end

    it 'only adds question with existing tags' do
      create :question, tags: []
      exam = create :exam, random_questions: { amss: 1 }

      expect(exam.questions.count).to eq(0)
    end
  end
end
