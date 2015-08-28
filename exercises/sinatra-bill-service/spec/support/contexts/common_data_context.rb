shared_context :common_data do
  let(:valid_bill_id) { '10000002' }
  let(:invalid_bill_id) { '999' }
  let(:bill_ids_response) { JSON.generate({ids: %w{bill_id_1 bill_id_2 bill_id_3}}) }

  let(:valid_username) { 'robertmkhall' }
  let(:invalid_username) { 'invalid_username' }
end