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

  describe '.where_tag' do
    it 'returns all questions that contain a given tag' do
      question = create :question, tags: ['amss', 'bases', 'rescate']

      result = Question.where_tag('amss')

      expect(result.first).to eq(question)
    end

    it "should return empty ActiveRecord::Relation if key not found" do
      expect(Question.where_tag('amss')).to eq []
    end
  end

  describe '#add_tag' do
    it 'should append tag to question and belonging user' do
      question = create :question

      question.add_tag('new tag')

      expect(question.tags.length).to eq(1)
      expect(question.user.tags).to eq(['new tag'])
    end
  end
end
