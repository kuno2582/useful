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
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.roadAddress;
					//fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				var obj = opener.memform;
                //document.getElementById('POST_NO1').value = Left(data.zonecode,3); //5자리 새우편번호 사용
				//document.getElementById('POST_NO2').value = Right(data.zonecode,2); //5자리 새우편번호 사용
                //document.getElementById('ADDR1').value = fullAddr;
				obj.POST_NO1.value = Left(data.zonecode,3); //5자리 새우편번호 사용
				obj.POST_NO2.value = Right(data.zonecode,2); //5자리 새우편번호 사용
				obj.ADDR1.value = fullAddr;

				window.close();

                // 커서를 상세주소 필드로 이동한다.
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
<title>타이틀</title>
<style>
	body { overflow-y:hidden; margin-top:0; margin-left:0; }
</style>
<body onload="execDaumPostcode();">
<div id="wrap" style="display:none;border:1px solid;width:500px;height:300px;margin:0 0;padding:0 0;position:relative"></div>
</body>
</html>





<!--입력받는 input이 존재하는 파일 S -->
<input type="text" name="POST_NO1" id="POST_NO1" size="5" readonly style="width:70px; vertical-align:middle; margin-right:5px;" />- <input type="text" name="POST_NO2" id="POST_NO2" size="5" readonly style="width:70px; vertical-align:middle;" /><a href="javascript:fFindAddr();" class="brifBtn3">우편번호 검색</a>
<script>
function fFindAddr() {
	var url = "/member/memb_find_post.asp";
	launchCenter(url, "주소찾기", 475,567,"Yes");
}
</script>
<!--입력받는 input이 존재하는 파일 E -->