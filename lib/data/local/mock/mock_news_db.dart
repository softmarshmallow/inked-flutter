import 'package:inked/data/local/mock/base.dart';
import 'package:inked/data/model/news.dart';

class MockNewsDatabase extends BaseMockDatabase<News>{
  static List<News> allNewsDataList = [
    News(title: '구로구 "이스라엘 여행객 집단발병, 신천지 관련 파악 안돼"', tags: ["질병", "코로나"], content: html_example),
    News(title: '마지막 청정지역 울산마저… 코로나, 한 달만에 전국 휩쓸다'),
    News(title: '제주 코로나 호텔 직원 맥주집·대형마트 갔다…지역 확산 우려'),
    News(title: "아베 정권, '독도는 일본땅' 억지주장 행사에 8년째 차관급 파견"),
  ];

  static const String html_example = """
  <html><body><div class="_article_body_contents" id="articleBodyContents">\n\n\n\n\n<span class="end_photo_org"><img alt="" src="https://imgnews.pstatic.net/image/016/2020/02/24/202002240115453282301_20200224012138_01_20200224012302355.jpg?type=w647"/><em class="img_desc">(사진=호날두 SNS 캡처)</em></span><br/>이탈리아가 코로나 사태에 직격탄을 맞은 가운데 축구계의 별 크리스티아누 호날두가 어떤 메시지를 건넬지 관심이 모인다. 중국을 향해서는 위로를 전한 과거가 있는 그다.<br/><br/>23일(현지시간) ANSA 통신 등에 따르면 이탈리아 보건당국은 현재 잠정 집계된 전국의 코로나19 확진자 수가 132명이라고 공개했다. 코로나19 확산은 이탈리아 축구계에도 영향을 끼칠 것으로 보인다<br/><br/>코로나19가 이탈리아 북부지역을 강타하면서 해당 지역에 연고를 둔 유벤투스 역시 무관중 경기 등 코로나19에 대한 대비가 언급되는 것으로 알려졌다.<br/><br/>이에 따라 유벤투스의 에이스 호날두의 행보도 주목받고 있다. 그가 지난 20일 축구화 신제품 발표 행사에 참석해 "바이러스로 고통 받는 중국 국민들을 위해 기도한다. 아름다운 중국에 가고 싶다"고 말했음을 시나 스포츠가 보도한 바 있다.<br/><br/>지난해 7월 K리그 \'노쇼\' 사태가 불거지기 앞서 중국에서 뜨거운 환영을 받았던 호날두다. 중국 방문 당시 호날두는 경기 외에도 다양한 행사에 참석해 모습을 보였고 어린 팬에게 직접 다가가 사인을 해 뜨거운 박수를 받기도 했다.<br/><br/>반면 한국에서는 완전히 달라진 모습이었다. 중국 방문 후 한국을 찾았던 호날두는 입국장에서부터 피곤함을 이기지 못한 모습이었으며 각종 행사에도 불참해 빈축을 샀다. 이어 6만5000명의 팬이 가득 모인 팀K리그와 경기에서도 1분도 그라운드에 모습을 보이지 않아 \'노쇼\' 논란을 샀다.<br/><br/>이번 코로나 사태에 대해서도 호날두는 중국에 대한 언급은 있었지만 한국에 대한 직접적인 언급은 피했다. 이탈리아 코로나 사태에 호날두가 어떤 메시지를 전할지 관심이 모인다.<br/>culture@heraldcorp.com<br/><br/><a href="http://mbiz.heraldcorp.com/event/index_200207.php%20" target="_blank">▶채널 구독하면 신세계 상품권과 에어팟 프로를 쏜다</a><br/><br/><a href="http://www.heraldenglish.com/" target="_blank">▶호주대사관과 함께하는 헤럴드 영어말하기대회</a> <a href="http://biz.heraldcorp.com" target="_blank">▶헤럴드경제 사이트 바로가기</a> <br/><br/><br/><br/>- Copyrights ⓒ 헤럴드경제 &amp; heraldbiz.com, 무단 전재 및 재배포 금지 -\n\t\n</div></body></html>
  """;

  @override
  Future create(record) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future get(String re) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<List> list() {
    // TODO: implement list
    throw UnimplementedError();
  }

  @override
  Future update(String re, record) {
    // TODO: implement patch
    throw UnimplementedError();
  }
}
