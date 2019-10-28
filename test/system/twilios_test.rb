require "application_system_test_case"

class TwiliosTest < ApplicationSystemTestCase
  setup do
    @twilio = twilios(:one)
  end

  test "visiting the index" do
    visit twilios_url
    assert_selector "h1", text: "Twilios"
  end

  test "creating a Twilio" do
    visit twilios_url
    click_on "New Twilio"

    click_on "Create Twilio"

    assert_text "Twilio was successfully created"
    click_on "Back"
  end

  test "updating a Twilio" do
    visit twilios_url
    click_on "Edit", match: :first

    click_on "Update Twilio"

    assert_text "Twilio was successfully updated"
    click_on "Back"
  end

  test "destroying a Twilio" do
    visit twilios_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Twilio was successfully destroyed"
  end
end
