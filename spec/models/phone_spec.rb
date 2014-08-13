require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = create(:contact)
    create(:home_phone, contact: contact, phone: '050-973-0702')
    mobile_phone = build(:mobile_phone, contact: contact, phone: '050-973-0702')
    expect(mobile_phone).to have(1).error_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    create(:mobile_phone, phone: '050-973-0702')
    expect(build(:mobile_phone, phone: '050-973-0702')).to be_valid
  end

end
