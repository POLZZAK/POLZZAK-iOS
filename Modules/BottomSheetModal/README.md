# BottomSheetModal

## **0. ScreenShot**

![BottomSheetModal](https://github.com/POLZZAK/POLZZAK-iOS/assets/62927862/45d4398f-f99f-4e81-9495-fe7c140153f1)

## **1. 모듈 개요**

- **모듈 이름**: BottomSheetModal
- **담당자**: Pane
- **설명**:
    - 뷰 컨트롤러를 모달 형태로 표시하며, 이 모달은 최대, 중간, 최소(닫기)의 세 가지 상태를 가질 수 있다.
    - 사용자는 모달의 상단 핸들을 드래그하여 이 세 가지 상태 중 하나로 변경할 수 있다.

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
│   ├── BottomSheetViewController.swift
│   ├── BottomSheetPresentationController.swift
│   └── BottomSheetState.swift
└── Tests
```

## **3. 주요 컴포넌트**

### **3.1. BottomSheetViewController**

- 모달의 주요 로직이 포함된 컨트롤러. 사용자의 드래그 동작에 응답하여 모달의 상태를 변경한다.

### **3.2. BottomSheetPresentationController**

- **`UIPresentationController`**의 커스터마이징된 버전. 모달의 표시 및 숨김에 대한 애니메이션과 동작을 정의한다.

### **3.3. BottomSheetState**

- 모달의 가능한 세 가지 상태를 나타내는 열거형 타입이다.

## **4. 사용 방법**

### **4.1. BottomSheetViewController**

- **사용**:
    - **`BottomSheetViewController`**를 상속받아 커스터마이징 된 뷰 컨트롤러를 생성한다.
    - 해당 컨트롤러를 모달로 표시하려면 표준 **`present(_:animated:completion:)`** 메서드를 사용한다.
    - **`modalPresentationStyle`**을 **`.custom`**으로 설정한다.

### **4.2. BottomSheetState**

- **사용**:
    - 필요에 따라 **`.zero`**, **`.short(height: CGFloat)`**, **`.full`** 중 하나의 상태로 설정하여 **`BottomSheetViewController`**의 초기 상태를 정의한다.

## **5. 테스트**

### **5.1. BottomSheetModalDemoAppUITests**

- 데모앱을 통한 UI 테스트.

## **6. 예제 애플리케이션**

### **6.1. DemoApp**

- ***`ViewController.swift`***에서 모듈 사용 방법 확인.

## **7. 의존성**

- **`UIKit`**,  **`Extension`**, **`SharedResourcesModule` , `SnapKit`**
