require 'test_helper'

class TwiliosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @twilio = twilios(:one)
  end

  test "should get index" do
    get twilios_url
    assert_response :success
  end

  test "should get new" do
    get new_twilio_url
    assert_response :success
  end

  test "should create twilio" do
    assert_difference('Twilio.count') do
      post twilios_url, params: { twilio: {  } }
    end

    assert_redirected_to twilio_url(Twilio.last)
  end

  test "should show twilio" do
    get twilio_url(@twilio)
    assert_response :success
  end

  test "should get edit" do
    get edit_twilio_url(@twilio)
    assert_response :success
  end

  test "should update twilio" do
    patch twilio_url(@twilio), params: { twilio: {  } }
    assert_redirected_to twilio_url(@twilio)
  end

  test "should destroy twilio" do
    assert_difference('Twilio.count', -1) do
      delete twilio_url(@twilio)
    end

    assert_redirected_to twilios_url
  end
end
