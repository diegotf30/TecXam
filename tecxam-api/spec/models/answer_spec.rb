require "spec_helper"

describe Answer do
  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :correct }
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

  describe '#evaluate' do
    it 'returns evaluated answer with random variable values'  do
      answer = create :answer, :with_variables

      result = answer.evaluate

      expect(result).to be_a_kind_of(Numeric)
    end

    it 'returns answer with replaced vars if expression cant be evaluated'  do
      answer = create :answer, name: 'Napoleón murió en var', variables: { var: [1821] }

      result = answer.evaluate

      expect(result).to eq('Napoleón murió en 1821')
    end
  end

  context 'private' do
    describe '#parse' do
      it 'should prepare answer for ruby eval()' do
        answer = create :answer, :with_variables

        expect(answer.name.include? '^').to eq(true)
        expect(answer.parsed_name.include? '**').to eq(true)
      end
    end
  end
end
