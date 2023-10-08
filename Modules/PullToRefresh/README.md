# PullToRefresh

## 0. ScreenShot

![DemoApp.Gif](PullToRefresh%20556ae5ab903b4c48b805f3bf8692fc15/PullToRefreshDemoApp.gif)

DemoApp.Gif

## **1. 모듈 개요**

- **모듈 이름**: PullToRefresh
- **담당자**: Pane
- **설명**
    - **`UIRefreshControl()`**을 커스터마이징하여 사용자가 스크롤을 당겼을 때 나타나는 이미지를 사용자 정의할 수 있게 함.
    - ScrollView 내부에 Filter가 있을 때, 스크롤의 최상단은 Filter의 상단이며, Refresh 시의 스크롤 최상단은 Filter의 하단.
    - 기본 **`UIRefreshControl`** 인디케이터 대신 커스텀 **`UIActivityIndicatorView`** 사용.
    - Drag 시작 시 API 호출 및 RefreshControl 시작, Drag 종료 시 RefreshControl 종료.
    - shouldEndRefreshing을 트리거로 초기화.

## **2. 모듈의 구조**

```markdown
├── Config
│   └── Info.plist
├── DemoApp
│   ├── DemoAppResources
│   ├── DemoAppSources
│   └── DemoAppUITests
├── Derived
├── Resources
├── Sources
│   ├── CustomRefreshControl.swift
│   └── PullToRefreshProtocol.swift
└── Tests
```

## **3. 주요 컴포넌트**

### **3.1. PullToRefreshProtocol**

- Pull-to-refresh 기능을 위한 주요 프로토콜.
- 새로고침과 관련된 주요 이벤트와 액션 정의.

### **3.2. CustomRefreshControl**

- **`UIRefreshControl`**의 커스텀 버전.
- 초기 위치 조절을 위해 **`topPadding`** 사용

## **4. 사용 방법**

### **4.1. PullToRefreshProtocol**

- **ViewController**
    - **scrollViewWillBeginDragging(UIScrollViewDelegate)**
        - customRefreshControl.resetRefreshControl()
    - **scrollViewDidEndDragging(UIScrollViewDelegate)**
        - viewModel.didEndDraggingSubject.send(true)
    - **shouldEndRefreshing 바인딩**
        - customRefreshControl.endRefreshing()
        - viewModel.resetPullToRefreshSubjects()
- **ViewModel**
    - **PullToRefreshProtocol 채택:** 필요한 메서드와 속성을 구현.
    - **init 초기화:** setupPullToRefreshBinding()
    - **API통신 이후:** isApiFinishedLoadingSubject.send(true)

### **4.2. CustomRefreshControl**

- **`init`**
    - 패딩값 설정
- **TableView 설정(CollectionView 설정)**
    - `**tableView.refreshControl = customRefreshControl**`
    - `**customRefreshControl.observe(scrollView: tableView)**`

### **4.3 참고사항**

- customRefreshControl의 리셋은 shouldEndRefreshing에서 안하는 이유는 리프레시가 종료되어도 애니메이션은 보여야되기때문.
- shouldEndRefreshing에 있으면 스크롤이 돌아갈때 리프레시 이미지가 노출됨.

## **5. 테스트**

### **5.1. PullToRefreshTests**

- 모듈의 주요 기능에 대한 유닛 테스트.

### **5.2. PullToRefreshDemoAppUITests**

- 데모앱을 통한 UI 테스트.

## **6. 예제 애플리케이션**

### **6.1. DemoApp**

- **`ViewController.swift`**에서 모듈 사용 방법 확인.

## **7. 의존성**

- **`Combine`**, **`UIKit`**, **`SharedResourcesModule`**.