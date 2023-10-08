        #!/bin/sh

        PROJECT_DIR="$(pwd)"
        PROJECT_NAME="POLZZAK"
        RUN_SCRIPT="${PROJECT_DIR}/run generate --testable ${PROJECT_NAME}"

        # Directories
        REPOSITORY_DIR="${PROJECT_DIR}/Sources/DataLayer/Repositories"
        MAPPER_DIR="${PROJECT_DIR}/Sources/DataLayer/Network/Mappers"
        BASIC_SERVICE_DIR="${PROJECT_DIR}/Sources/Network/NetworkService"
        SERVICE_DIR="${PROJECT_DIR}/Sources/DataLayer/Network/Services"

        # Directories Mocks
        MOCK_REPOSITORY_DIR="${PROJECT_DIR}/Tests/POLZZAKTests/Mocks/Repositories"
        MOCK_MAPPER_DIR="${PROJECT_DIR}/Tests/POLZZAKTests/Mocks/Mappers"
        MOCK_SERVICE_DIR="${PROJECT_DIR}/Tests/POLZZAKTests/Mocks/Services"

        generate_mock() {
            INPUT="$1"
            OUTPUT="$2"
            ${RUN_SCRIPT} --output "$OUTPUT" "$INPUT"
        }

        # Repository Mocks
        generate_mock "${REPOSITORY_DIR}/StampBoardsRepository.swift" "${MOCK_REPOSITORY_DIR}/MockStampBoardsRepository.swift"
        generate_mock "${REPOSITORY_DIR}/LinkManagementRepository.swift" "${MOCK_REPOSITORY_DIR}/MockLinkManagementRepository.swift"
        generate_mock "${REPOSITORY_DIR}/CouponRepository.swift" "${MOCK_REPOSITORY_DIR}/MockCouponRepository.swift"
        generate_mock "${REPOSITORY_DIR}/NotificationRepository.swift" "${MOCK_REPOSITORY_DIR}/MockNotificationRepository.swift"

        # Services Mocks
        generate_mock "${BASIC_SERVICE_DIR}/NetworkService.swift" "${MOCK_SERVICE_DIR}/MockNetworkServiceProvider.swift"
        generate_mock "${SERVICE_DIR}/StampBoardsService.swift" "${MOCK_SERVICE_DIR}/MockStampBoardsService.swift"
        generate_mock "${SERVICE_DIR}/LinkManagementService.swift" "${MOCK_SERVICE_DIR}/MockLinkManagementService.swift"
        generate_mock "${SERVICE_DIR}/CouponService.swift" "${MOCK_SERVICE_DIR}/MockCouponService.swift"
        generate_mock "${SERVICE_DIR}/NotificationService.swift" "${MOCK_SERVICE_DIR}/MockNotificationService.swift"
