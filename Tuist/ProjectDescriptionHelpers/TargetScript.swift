//
//  TargetScript.swift
//  POLZZAK
//
//  Created by 이정환 on 2023/09/26.
//

import ProjectDescription

extension TargetScript {
    public static let generateMocks = TargetScript.pre(
        path: .relativeToRoot("Scripts/GenerateMocks.sh"),
        name: "GenerateMocks"
    )
}
