# Toast

# **Toast**

## **0. ScreenShot**

![Toast](https://github.com/POLZZAK/POLZZAK-iOS/assets/62927862/a7d86720-e7bb-439d-be03-5acbb21f7091)

## **1. 모듈 개요**

- **모듈 이름**: Toast
- **담당자**: Pane
- **설명**:
    - 화면에 잠깐 노출되는 알림 메시지를 위한 토스트 모듈입니다.
    - 자동 및 수동으로 종료할 수 있습니다.
    - 자동 시간: 시작 0.5초, 유지 2초, 종료 0.5초

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
    ├── Toast.swift
    └── ToastType.swift
```

## **3. 주요 컴포넌트**

### **3.1. Toast**

- 토스트 메시지를 보여주기 위한 주요 클래스입니다.
- 각종 알림 메시지를 보여줄 때 사용됩니다.

### **3.2. ToastType**

- 토스트의 타입을 정의하는 enum입니다.
- 현재는 성공과 오류 두 가지 타입이 있습니다.

## **4. 사용 방법**

### **4.1. Toast**

- **사용**:
    - **`Toast`** 클래스의 인스턴스를 생성하고, 원하는 토스트 타입을 인자로 전달합니다.
    - **`show()`** 메서드를 호출하여 토스트를 화면에 보여줍니다.

### **4.2. ToastType**

- **사용**:
    - 원하는 토스트 타입 (**`.success`** 또는 **`.error`**)를 선택하여 **`Toast`** 클래스의 생성자에 전달합니다.

## **5. 테스트**

### **5.1. ToastDemoAppUITests**

- 데모앱을 통한 UI 테스트입니다.

## **6. 예제 애플리케이션**

### **6.1. DemoApp**

- 토스트 알림을 보여주기 위한 버튼과 관련 동작을 확인할 수 있습니다.

## **7. 의존성**

- **`UIKit`**, **`SnapKit`**, **`Extension`**, **`SharedResources`**
