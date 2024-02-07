package com.manchott.TTT.domain.game.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.*;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Category {
    @Id
    @Column(name = "category_id", nullable = false)
    private Long categoryId;

    private String categoryName;
    private String categoryNameKR;

    @Builder
    public Category(Long categoryId, String categoryName, String categoryNameKR) {
        this.categoryId = categoryId;
        this.categoryName = categoryName;
        this.categoryNameKR = categoryNameKR;
    }

}
