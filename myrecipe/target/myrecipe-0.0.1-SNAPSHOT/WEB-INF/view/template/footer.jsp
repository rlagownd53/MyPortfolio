<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<script src="http://code.jquery.com/jquery-3.2.1.js"></script>

            </main>
            <footer>
                <h2>KG ITBANK 구로점 SW 개발자 양성반</h2>
                <address>서울특별시 금천구 가산동 벚꽃로 244 벽산디지털밸리5차 2층</address>
            </footer>
        </div>
        <a href="#" class="jcm-top hidden-xs hidden-sm">
			<img src="${pageContext.request.contextPath}/image/top_btn.png" width="50" height="50">
		</a>
		<script>
			$( document ).ready( function() {
			$( window ).scroll( function() {
			if ( $( this ).scrollTop() > 200 ) {
			$( '.jcm-top' ).fadeIn();
			} else {
			$( '.jcm-top' ).fadeOut();
			}
			} );
			$( '.jcm-top' ).click( function() {
			$( 'html, body' ).animate( { scrollTop : 0 }, 400 );
			return false;
			} );
			} );
		</script>
    </body>
</html>