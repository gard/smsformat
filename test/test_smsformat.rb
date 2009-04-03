require "test/unit"
require "smsformat"

class TestSmsformat < Test::Unit::TestCase
  def test_wap_push
    assert_equal("0605040B8423F0010601AE02056A0045C60C036d2e676f6f676c652e636f6d000103476f6f676c65000101",
      Smsformat.wap_push("Google","http://m.google.com"))
    assert_equal("06:05:04:0B:84:23:F0:01:06:01:AE:02:05:6A:00:45:C6:0C:03:6d:2e:67:6f:6f:67:6c:65:2e:63:6f:6d:00:01:03:47:6f:6f:67:6c:65:00:01:01",
        Smsformat.wap_push("Google","http://m.google.com",":"))
  end
  
  def test_long_message
  end
  
  def test_vcard
  end
end
