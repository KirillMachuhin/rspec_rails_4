require 'spec_helper'

describe Phone do
  it "does not allow duplicate phone numbers per contact" do
    contact = Contact.create(email: 'tester@example.com', firstname: 'Aaron', lastname: 'Sumner')
    mobile_phone = contact.phones.create(phone_type: "mobile", phone: "050-973-0702")
    home_phone = contact.phones.create(phone_type: "home", phone: "050-973-0702")

    expect(home_phone).to have(1).error_on(:phone)
  end

  it "allows two contacts to share a phone number" do
    contact = Contact.create(email: 'tester@example.com', firstname: 'Aaron', lastname: 'Sumner')
    mobile_phone = contact.phones.create(phone_type: "mobile", phone: "050-973-0702")
    other_contact = Contact.create(email: 'tester@example.com', firstname: 'Jhonate', lastname: 'Sumner')
    other_phone = other_contact.phones.build(phone_type: "mobile", phone: "050-973-0702")

    expect(other_phone).to be_valid
  end

end
