class Smsformat
  VERSION = '1.0.0'
  
  def Smsformat.wap_push(title, url, hex_delimiter = "", header_delimiter = nil)
    # remove protokoll if present since we are adding it with WBXML "0C"
    url.gsub!(/^http:\/\//,'')
    # setup the dataheader
    # UDHL = 6 bytes, the length of the header
    data = "06" + hex_delimiter
    # Information Element Identifier IEI 05 = Application port addressing scheme, 16 bit address
    data += "05" + hex_delimiter
    # Information Element Data Length (IEDL) = 4 bytes
    data += "04" + hex_delimiter
    # destination port = 2948 WAP Push connectionless session service (client side), Protocol: WSP/Datagram
    data += "0B" + hex_delimiter
    data += "84" + hex_delimiter
    # originator port = 9200 WAP connectionless session service Protocol: WSP/Datagram
    data += "23" + hex_delimiter
    data += "F0"
    data += hex_delimiter if header_delimiter.nil?
    data += header_delimiter unless header_delimiter.nil?
    # setup the data payload
    # TID
    data += "01" + hex_delimiter
    # PDU Type (Push PDU)
    data += "06" + hex_delimiter
    # Headers Length
    data += "01" + hex_delimiter
    # B6 Content-Type - application/vnd.wap.connectivity-wbxml
    data += "AE" + hex_delimiter
    # === WBXML ===
    # <Version number - WBXML version 1.2>
    data += "02" + hex_delimiter
    # <SI 1.0 Public Identifier>
    data += "05" + hex_delimiter
    # <Charset=UTF-8 (MIBEnum 106)>
    data += "6A" + hex_delimiter
    # <String table length>
    data += "00" + hex_delimiter
    # <SI element start, with content 0x05 | 0x40>
    data += "45" + hex_delimiter
    # C6 <indication element start>
    data += "C6" + hex_delimiter
    # http://
    data += "0C" + hex_delimiter
    # (next is an ASCII string for the URL, terminate with 00)
    data += "03" + hex_delimiter
    url.each_byte { |b| data += b.to_s(16) + hex_delimiter} # URL as a byte array converted to hex. data.unpack('H*')
    # 00 terminate string with 00
    data += "00" + hex_delimiter
    # 01 <indication element attributes end>
    data += "01" + hex_delimiter
    # 03 (next is an ASCII string for title, terminate with 00)
    data += "03" + hex_delimiter
    title.each_byte { |b| data += b.to_s(16) + hex_delimiter}  #// Title as a byte array converted to hex
    # 00 terminate string with 00
    data += "00" + hex_delimiter
    # 01 <indication element attributes end>
    data += "01" + hex_delimiter
    # 03 (next is an ASCII string for title, terminate with 00)
    data += "01"
    return data
  end
end
