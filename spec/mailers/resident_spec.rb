require "rails_helper"

RSpec.describe ResidentMailer, type: :mailer do
  describe 'registration' do
    let(:resident) { create(:resident) }

    subject { ResidentMailer.with(resident: resident).registration }

    it 'subject' do
      expect(subject.subject).to eq('Cadastro Realizado')
    end

    it 'sends to resident email' do
      expect(subject.to).to eq([resident.email])
    end

    it 'title' do
      expect(subject.body.encoded).to match('Seu cadastro foi realizado com sucesso na nossa plataforma.')
    end
  end

  describe 'status_update' do
    let(:resident) { create(:resident) }

    subject { ResidentMailer.with(resident: resident).status_update }

    it 'subject' do
      expect(subject.subject).to eq('Status Alterado')
    end

    it 'sends to resident email' do
      expect(subject.to).to eq([resident.email])
    end

    it 'title' do
      expect(subject.body.encoded).to match('Seu status foi alterado na nossa plataforma, verifique o novo status abaixo.')
    end

    it 'status' do
      expect(subject.body.encoded).to match(I18n.t(resident.status))
    end
  end
end
