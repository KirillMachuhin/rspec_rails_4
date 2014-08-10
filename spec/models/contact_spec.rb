require 'spec_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    contact = Contact.new(
      firstname: 'Aaron',
      lastname: 'Sumner',
      email: 'tester@example.com')
    expect(contact).to be_valid
  end

  it "is invalid without a firstname" do
    expect(Contact.new(firstname: nil)).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
    expect(Contact.new(lastname: nil)).to have(1).errors_on(:lastname)
  end

  it "is invalid without an email address" do
    expect(Contact.new(email: nil)).to have(1).error_on(:email)
  end

  it "is invalid with a duplicate email address" do
    Contact.create(email: 'tester@example.com', firstname: 'Aaron', lastname: 'Sumner')
    contact = Contact.new(email: 'tester@example.com', firstname: 'Aaron', lastname: 'Sumner')
    expect(contact).to have(1).error_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = Contact.create(email: 'tester@example.com', firstname: 'Aaron', lastname: 'Sumner')
    expect(contact.name).to eq("Aaron Sumner")
  end

  it "returns a sorted array of result that match" do
    samner = Contact.create(email: 'jhone@example.com', firstname: 'Jhone', lastname: 'Samner')
    suzuki = Contact.create(email: 'july@example.com', firstname: 'July', lastname: 'Suzuki')
    huston = Contact.create(email: 'huston@example.com', firstname: 'Huston', lastname: 'Petterson')

    expect(Contact.by_letter("S")).to eq [samner, suzuki]
  end

  it "is return list according to incoming data" do
    huston = Contact.create(email: 'huston@example.com', firstname: 'Huston', lastname: 'Petterson')

    expect(Contact.by_letter("J")).to_not include huston
  end

end
