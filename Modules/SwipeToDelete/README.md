# SwipeToDelete

## **0. ScreenShot**

![SwipeToDelete](https://github.com/POLZZAK/POLZZAK-iOS/assets/62927862/cd743ebd-7d9e-4bfc-8160-2b453a9ee645)

## **1. 모듈 개요**

- **모듈 이름**: SwipeToDelete
- **담당자**: 이정환
- **설명**:
    - **`UITableView`**에서 셀을 좌우로 스와이프하여 삭제하는 기능을 위한 모듈입니다.
    - 팬 제스처를 통한 삭제 액션의 시각적 표현과 셀의 삭제 처리를 쉽게 할 수 있습니다.
    - 삭제영역 디자인의 제한 때문에 기본 스와이프를 사용하지 않았습니다.

## **2. 모듈의 구조**

```markdown
├── Config
│   └── Info.plist
├── DemoApp
│   ├── DemoAppResources
│   ├── DemoAppSources
│   └── DemoAppUITests
├── Derived
└── Sources
    ├── Swipeable.swift
    └── SwipeableTableViewCell.swift
```

## **3. 주요 컴포넌트**

### **3.1. SwipeableTableViewCell**

- 주된 기능을 제공하는 클래스입니다.
- 토스트 메시지와 유사한 UI 애니메이션으로 사용자에게 메시지를 보여줍니다.
- 팬 제스처를 통해 셀을 스와이프하여 삭제할 수 있습니다.

### **3.2. Swipeable**

- 삭제 가능한 요소의 프로토콜입니다.
- 해당 프로토콜을 구현하는 요소는 스와이프하여 삭제될 수 있습니다.

## **4. 사용 방법**

### **4.1. SwipeableTableViewCell**

- **사용**:
    - **`SwipeableTableViewCell`**을 상속받아 원하는 UITableViewCell을 구현합니다.
    - 해당 셀에 팬 제스처 및 삭제 버튼의 동작을 쉽게 추가할 수 있습니다.

### **4.2. Swipeable**

- **사용**:
    - 삭제 가능한 요소에 **`Swipeable`** 프로토콜을 구현합니다.
    - 스와이프 제스처와 관련된 메서드들을 사용할 수 있게 됩니다.

## **5. 테스트**

### **5.1. SwipeToDeleteDemoAppUITests**

- 데모앱을 통한 UI 테스트입니다.

## **6. 예제 애플리케이션**

### **6.1. DemoApp**

- 스와이프하여 삭제하는 액션과 관련된 동작을 확인할 수 있습니다.

## **7. 의존성**

- **`UIKit`**, **`SnapKit`**, **`SharedResources`**
