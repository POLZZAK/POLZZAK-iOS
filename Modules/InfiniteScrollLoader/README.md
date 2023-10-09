# InfiniteScrollLoader

## **0. ScreenShot**

![InfiniteScrollLoader](https://github.com/POLZZAK/POLZZAK-iOS/assets/62927862/433476c2-673e-4d35-9502-8e3dce024a2b)

## **1. 모듈 개요**

- **모듈 이름**: InfiniteScrollLoader
- **담당자**: Pane
- **설명**:
    - 리스트의 하단에 도달했을 때 자동으로 추가 데이터를 로드하는 무한 스크롤 기능을 구현하기 위한 모듈이다.
    - UIScrollViewDelegate를 확장하여 쉽게 해당 기능을 적용할 수 있다.

## **2. 모듈의 구조**

```markdown
├── Config
│   └── Info.plist
├── DemoApp
│   ├── DemoAppResources
│   ├── DemoAppSources
│   └── DemoAppUITests
├── Derived
├── Sources
│   ├── InfiniteScrolling.swift
│   └── InfiniteScrollingViewModel.swift
```

## **3. 주요 컴포넌트**

### **3.1. InfiniteScrolling**

- 스크롤 뷰의 하단에 도달했을 때 호출되는 메서드를 포함한 프로토콜이다.
- UIViewController 및 UIScrollViewDelegate와 함께 사용된다.

### **3.2. InfiniteScrollingViewModel**

- 무한 스크롤 동작에 필요한 주요 데이터 및 함수를 포함한 프로토콜이다.
- 데이터 로드 상태 및 동작을 관리한다.

## **4. 사용 방법**

### **4.1. InfiniteScrolling**

- **사용**:
    - **`InfiniteScrolling`** 프로토콜을 UIViewController에 채택한다.
    - **`scrollViewDidReachEnd(_:)`** 메서드를 UIScrollViewDelegate에 구현하여 적절한 액션을 수행하도록 한다.

### **4.2. InfiniteScrollingViewModel**

- **사용**:
    - **`InfiniteScrollingViewModel`** 프로토콜을 채택한 ViewModel을 만든다.
    - **`setupBottomRefreshBindings()`** 메서드를 호출하여 바인딩을 설정한다.

## **5. 테스트**

### **5.1. InfiniteScrollLoaderDemoAppUITests**

- 데모앱을 통한 UI 테스트.

## **6. 예제 애플리케이션**

### **6.1. DemoApp**

- 리스트의 하단에 도달하면 색상이 무지개색 순서로 변경된 셀이 추가됩니다.

## **7. 의존성**

- **`UIKit`**, **`Combine`**
