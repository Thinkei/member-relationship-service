require 'spec_helper'

describe Helpers::JSONResponseHelper do
  let(:object) do
    Class.new { include Helpers::JSONResponseHelper }.new
  end

  describe '#render_error' do
    let(:error) { { 'message' => 'error message', 'reason' => 'error_code' } }

    subject { JSON.parse(object.render_error(error)) }

    it { is_expected.to have_key('error') }

    it 'returns with list of errors' do
      expect(subject['error']).to include('errors' => [error])
    end
  end

  describe '#render_array' do
    let(:array) { [{ 'code' => 'submit_leave_request' }, { 'code' => 'submit_timesheet' }] }

    subject { JSON.parse(object.render_array(array)) }

    it { is_expected.to have_key('data') }

    it 'returns with list of items' do
      expect(subject['data']).to include('items' => array)
    end
  end

  describe '#render_item' do
    let(:item) { { 'code' => 'submit_leave_request' } }

    subject { JSON.parse(object.render_item(item)) }

    it { is_expected.to include('data' => item) }
  end
end
