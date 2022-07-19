require 'rails_helper'

RSpec.describe Resident, type: :model do
  let(:resident) { build(:resident) }

  it 'has a valid factory' do
    expect(resident).to be_valid
  end

  it { is_expected.to(validate_presence_of(:full_name)) }
  it { is_expected.to(validate_presence_of(:document)) }
  it { is_expected.to(validate_presence_of(:health_card_document)) }
  it { is_expected.to(validate_presence_of(:email)) }
  it { is_expected.to(validate_presence_of(:birthdate)) }
  it { is_expected.to(validate_presence_of(:phone)) }
  it { is_expected.to(have_one_attached(:photo)) }
  it { is_expected.to(validate_length_of(:full_name).is_at_most(255)) }
  it { is_expected.to(validate_length_of(:email).is_at_most(255)) }
  it { is_expected.to(have_many(:addresses)) }
  it { is_expected.to(validate_presence_of(:status)) }
  it { is_expected.to(define_enum_for(:status).with_values(%w[inactive active])) }
  it { is_expected.to(accept_nested_attributes_for(:addresses)) }

  context 'when validates email' do
    describe 'with valid email' do
      it 'resident is valid' do
        expect(resident).to be_valid
      end
    end

    describe 'with invalid email' do
      let(:resident) { build(:resident, :with_invalid_email) }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end
  end

  context 'when validates document' do
    describe 'with valid document' do
      it 'resident is valid' do
        expect(resident).to be_valid
      end
    end

    describe 'with invalid document' do
      let(:resident) { build(:resident, :with_invalid_document) }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end
  end

  context 'when validates birthdate' do
    describe 'with birthdate from 0 up to 125 years ago' do
      it 'resident is valid' do
        expect(resident).to be_valid
      end
    end

    describe 'with birthdate backward than 125 years' do
      let(:resident) { build(:resident, :with_birthdate_backward_than_125_years) }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end

    describe 'with birthdate backward than 125 years' do
      let(:resident) { build(:resident, :with_birthdate_forward_than_today) }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end
  end

  context 'when validates presence of photo' do
    describe 'with photo present' do
      it 'resident is valid' do
        expect(resident).to be_valid
      end
    end

    describe 'with photo no present' do
      let(:resident) { build(:resident, photo: nil) }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end
  end

  context 'when validate health card document as health card number' do
    describe 'with length different than 15' do
      let(:resident) { build(:resident, :with_health_card_length_different_than_fifteen) }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end

    describe 'with repeated digits' do
      let(:resident) { build(:resident, :with_repeated_digits_for_health_card) }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end

    describe 'with first digit from 1 up to 2' do
      context 'with valid number' do
        let(:health_document) { %w[115265421250000 245859676060009].sample }
        let(:resident) { build(:resident, health_card_document: health_document) }

        it 'resident is valid' do
          expect(resident).to be_valid
        end
      end

      context 'with invalid number' do
        let(:health_document) { %w[115265321250000 245819376060009].sample }
        let(:resident) { build(:resident, health_card_document: health_document) }

        it 'resident is invalid' do
          expect(resident).to be_invalid
        end
      end
    end

    describe 'with first digit from 7 up to 9' do
      context 'with valid number' do
        let(:health_document) { %w[972475396020009 833718058570002 715907584150009].sample }
        let(:resident) { build(:resident, health_card_document: health_document) }

        it 'resident is valid' do
          expect(resident).to be_valid
        end
      end

      context 'with invalid number' do
        let(:health_document) { %w[972475399020009 833788158570002 715807584150009].sample }
        let(:resident) { build(:resident, health_card_document: health_document) }

        it 'resident is invalid' do
          expect(resident).to be_invalid
        end
      end
    end

    describe 'with first digit different than 1,2,7,8,9' do
      let(:resident) { build(:resident, health_card_document: "#{(3..6).to_a.sample}91455326600008") }

      it 'resident is invalid' do
        expect(resident).to be_invalid
      end
    end

    context 'when validates phone' do
      describe 'with brazilian phone' do
        it 'resident is valid' do
          expect(resident).to be_valid
        end
      end

      describe 'with invalid brazilian phone' do
        let(:resident) { build(:resident, phone: '550099317838') }

        it 'resident is invalid' do
          expect(resident).to be_invalid
        end
      end

      describe 'with international phone' do
        let(:resident) { build(:resident, phone: '524775484186') }

        it 'resident is invalid' do
          expect(resident).to be_invalid
        end
      end
    end
  end
end
