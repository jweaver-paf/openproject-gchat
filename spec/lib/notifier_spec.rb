require 'spec_helper'

describe OpenProject::gchat::Notifier do
  context 'when gchat url is not specified' do
    before do
      Setting.plugin_openproject_gchat['webhook_url'] = nil
    end

    it 'should raise error' do
      expect { OpenProject::gchat::Notifier.say text: "test" }.to raise_error(URI::InvalidURIError, /bad URI/i)
    end
  end

  describe '#say' do
    let(:url) { 'https://hooks.gchat.com/services/foo' }
    let(:message) { 'message' }
    let(:dummy) do
      Object.new.tap do |d|
        def d.post(*args)
        end
      end
    end

    before do
      Setting.plugin_openproject_gchat['webhook_url'] = url
    end

    it 'should use the URL from the settings' do
      expect(::gchat::Notifier).to receive(:new).with(url).and_return(dummy)
      expect(dummy).to receive(:post).with text: message, link_names: 1

      OpenProject::gchat::Notifier.say text: message
    end

    context 'with URL overriden' do
      let(:override_url) { 'https://hooks.gchat.com/services/bar' }

      it 'should use the override URL' do
        expect(::gchat::Notifier).to receive(:new).with(override_url).and_return(dummy)
        expect(dummy).to receive(:post).with text: message, link_names: 1

        OpenProject::gchat::Notifier.say text: message, webhook_url: override_url
      end
    end
  end
end
