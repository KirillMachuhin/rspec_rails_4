require 'spec_helper'

describe Contact do
  it "is valid with a firstname, lastname and email" do
    expect(build(:contact)).to be_valid
  end

  it "is invalid without a firstname" do
    expect(build(:contact, firstname: nil)).to have(1).errors_on(:firstname)
  end

  it "is invalid without a lastname" do
    expect(build(:contact, lastname: nil)).to have(1).errors_on(:lastname)
  end

  it "is invalid without an email address" do
    expect(build(:contact, email: nil)).to have(1).error_on(:email)
  end

  it "is invalid with a duplicate email address" do
    create(:contact, email: 'tester@example.com')
    contact = build(:contact, email: 'tester@example.com')
    expect(contact).to have(1).error_on(:email)
  end

  it "returns a contact's full name as a string" do
    contact = create(:contact, firstname: 'John', lastname: 'Doe')
    expect(contact.name).to eq("John Doe")
  end

  it "returns a sorted array of result that match" do
    samner = create(:contact, lastname: 'Samner')
    suzuki = create(:contact, lastname: 'Suzuki')

    expect(Contact.by_letter("S")).to eq [samner, suzuki]
  end

  it "is return list according to incoming data" do
    huston = create(:contact, lastname: 'Huston')
    expect(Contact.by_letter("J")).to_not include huston
  end

  it "has three phone numbers" do
    expect(create(:contact).phones.count).to eq 3
  end

end
