//
//  Constants.swift
//  POLZZAK
//
//  Created by Jinyoung Kim on 2023/06/06.
//

// TODO: 앱 출시할때 KeychainKey의 값들을 좀더 임의의 값으로 바꾸기 (2023.06.05)
// TODO: 앱 출시할때 Constants 파일 gitignore에 추가하기

enum Constants {
    enum KakaoKey {
        static let nativeAppKey = "4c022153e5265c04e1050b2098179206"
    }
    
    enum KeychainKey {
        static let accessToken = "accessToken"
        static let refreshToken = "refreshToken"
        static let registerUsername = "registerUsername"
        static let registerSocialType = "registerSocialType"
    }
    
    enum UserDefaultsKey {
        static let userInfo = "UserDefaultsUserInfo"
    }
    
    enum URL {
        static let baseURL = "https://api.polzzak.co.kr/api/"
        static let localURL = "http://localhost:3000/"
    }
    
    enum Text {
        static let missionExamples = [
            "1시간 집중해서 공부하기",
            "강아지 목욕 시켜주기",
            "강아지 산책 시키고 오기",
            "게임하지 않기",
            "고양이 화장실 갈아주기",
            "공원 세바퀴 돌고 오기",
            "과자 안 먹기",
            "나갈 때 선크림 바르기",
            "나갔다 와서 옷 정리하기",
            "누워있지 않기",
            "떼 쓰지 않기",
            "목욕하기",
            "반찬 골고루 먹기",
            "밥 남기지 않고 싹싹 먹기",
            "밥 돌아다니지 않고 먹기",
            "방 불 꺼주기",
            "방 청소하기",
            "분리수거 하고 오기",
            "설거지하기",
            "숙제 하기",
            "시골 같이 가기",
            "시험 _점 맞아오기",
            "심부름 갔다 오기",
            "아이패드 그만하기",
            "애정표현 해주기",
            "엄마 아빠랑 외식하기",
            "엄마, 아빠 안마해주기",
            "엄마랑 같이 등산가기",
            "엄마랑 같이 책 한권 읽기",
            "영어 단어 시험 100점 맞아오기",
            "운동하기",
            "음식 포장 픽업해오기",
            "일기 쓰기",
            "일어나면 이불 정리하기",
            "일찍 잠자기",
            "입술 뜯지 않기",
            "장난감 정리하기",
            "책 한권 읽기",
            "청소기 밀기",
            "탄산 음료 안 먹기",
            "편식 안 하기",
            "하루 한 번 비타민 먹기",
            "하루 한 번 유산균 먹기",
            "학교 지각하지 않고 가기",
            "학원 가기",
            "학원 안 간다고 안 하기",
            "학원 지각하지 않고 가기",
            "한약 챙겨 먹기",
            "핸드폰 그만하기",
            "형/누나/오빠/언니와 싸우지 않기",
            "홍삼 챙겨 먹기"
        ]
    }
}
