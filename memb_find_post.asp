<% If Request.ServerVariables("HTTPS") = "on" Then %>
	<script src="https://spi.maps.daum.net/imap/map_js_init/postcode.v2.js"></script>
<% else %>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<% end if %>

<script type="text/javascript">
    var element_wrap = document.getElementById('wrap');
    function execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // �˾����� �˻���� �׸��� Ŭ�������� ������ �ڵ带 �ۼ��ϴ� �κ�.

                // �� �ּ��� ���� ��Ģ�� ���� �ּҸ� �����Ѵ�.
                // �������� ������ ���� ���� ��쿣 ����('')���� �����Ƿ�, �̸� �����Ͽ� �б� �Ѵ�.
                var fullAddr = ''; // ���� �ּ� ����
                var extraAddr = ''; // ������ �ּ� ����

                // ����ڰ� ������ �ּ� Ÿ�Կ� ���� �ش� �ּ� ���� �����´�.
                if (data.userSelectedType === 'R') { // ����ڰ� ���θ� �ּҸ� �������� ���
                    fullAddr = data.roadAddress;

                } else { // ����ڰ� ���� �ּҸ� �������� ���(J)
                    fullAddr = data.roadAddress;
					//fullAddr = data.jibunAddress;
                }

                // ����ڰ� ������ �ּҰ� ���θ� Ÿ���϶� �����Ѵ�.
                if(data.userSelectedType === 'R'){
                    //���������� ���� ��� �߰��Ѵ�.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // �ǹ����� ���� ��� �߰��Ѵ�.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // �������ּ��� ������ ���� ���ʿ� ��ȣ�� �߰��Ͽ� ���� �ּҸ� �����.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // �����ȣ�� �ּ� ������ �ش� �ʵ忡 �ִ´�.
				var obj = opener.memform;
                //document.getElementById('POST_NO1').value = Left(data.zonecode,3); //5�ڸ� �������ȣ ���
				//document.getElementById('POST_NO2').value = Right(data.zonecode,2); //5�ڸ� �������ȣ ���
                //document.getElementById('ADDR1').value = fullAddr;
				obj.POST_NO1.value = Left(data.zonecode,3); //5�ڸ� �������ȣ ���
				obj.POST_NO2.value = Right(data.zonecode,2); //5�ڸ� �������ȣ ���
				obj.ADDR1.value = fullAddr;

				window.close();

                // Ŀ���� ���ּ� �ʵ�� �̵��Ѵ�.
                //document.getElementById('ADDR2').focus();
            },
            onresize : function(size) {
                //element_wrap.style.height = size.height+'px';
            },
            width : '100%',
            height : '100%'
        }).embed(element_wrap);
		//element_wrap.style.display = 'block';
    }
	function Left(str, n) {
		if (n <= 0) {
			return "";
		} else if (n > String(str).length) {
			return str;
		} else {
			return String(str).substring(0, n);
		}
	}

	function Right(str, n) {
		if (n <= 0) {
			return "";
		} else if (n > String(str).length) {
			return str;
		} else {
			var iLen = String(str).length;
			return String(str).substring(iLen, iLen - n);
		}
	}
</script>
<html>
<meta http-equiv='Content-Type' content='text/html; charset=euc-kr'>
<title>Ÿ��Ʋ</title>
<style>
	body { overflow-y:hidden; margin-top:0; margin-left:0; }
</style>
<body onload="execDaumPostcode();">
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:0 0;padding:0 0;position:relative"></div>
</body>
</html>





<!--�Է¹޴� input�� �����ϴ� ���� S -->
<input type="text" name="POST_NO1" id="POST_NO1" size="5" readonly style="width:70px; vertical-align:middle; margin-right:5px;" />- <input type="text" name="POST_NO2" id="POST_NO2" size="5" readonly style="width:70px; vertical-align:middle;" /><a href="javascript:fFindAddr();" class="brifBtn3">�����ȣ �˻�</a>
<script>
function fFindAddr() {
	var url = "/member/memb_find_post.asp";
	launchCenter(url, "�ּ�ã��", 475,567,"Yes");
}
</script>
<!--�Է¹޴� input�� �����ϴ� ���� E -->