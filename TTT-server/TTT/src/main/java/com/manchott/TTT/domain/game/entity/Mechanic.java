package com.manchott.TTT.domain.game.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Mechanic {

    @Id
    @Column(name = "mechanic_id", nullable = false)
    private Long mechanicId;

    private String mechanicName;
    private String mechanicNameKR;
    @Builder

    public Mechanic(Long mechanicId, String mechanicName, String mechanicNameKR) {
        this.mechanicId = mechanicId;
        this.mechanicName = mechanicName;
        this.mechanicNameKR = mechanicNameKR;
    }

}
