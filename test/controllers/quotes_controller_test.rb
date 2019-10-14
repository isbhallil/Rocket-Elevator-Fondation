require 'test_helper'

class QuotesControllerTest < ActionDispatch::IntegrationTest
  test "should get quote" do
    get quotes_quote_url
    assert_response :success
  end

end
