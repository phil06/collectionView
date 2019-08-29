# CollectionViewHeaderTest1

## sticky header

아래로 스크롤할땐 헤더고정 + 위로 스크롤할땐 헤더가 함께 스크롤 되는 대신에, 위에서부터 사라지는것이 아닌 중간에 찌그러지는 형태
![](20190829_collectionview+stickey+header.gif)

- custom flowlayout 생성
  * sectionHeadersPinToVisibleBounds =  true 설정
  * layoutAttributesForSupplementaryView 메소드에서 스크롤에 따라 header frame 이 변경될 정보를 지정해줌
  * layoutAttributesForElements 가 없으면 크래시

- 위로 스크롤할때 cell 이 header를 가리므로 cellForItemAt 에서 cell.layer.zPosition = 999 설정
