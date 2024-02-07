package com.manchott.TTT.domain.game.entity;

import jakarta.persistence.*;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class Game {

    @Id
    @Column(name = "game_id", nullable = false)
    private Long gameId;

    private String type;
    private String thumbnail;
    private String nameEN;
    private String nameKR;
    private String weight;
    private String description;
    private String yearPublished;
    private String minPlayers;
    private String maxPlayers;
    private String playingTime;
    private String minPlayTime;
    private String maxPlayTime;

    @OneToMany(mappedBy = "game")
    private List<GameCategory> gameCategoryList = new ArrayList<>();
    @OneToMany(mappedBy = "game")
    private List<GameMechanic> gameMechanicList = new ArrayList<>();

    @Builder
    public Game(Long gameId, String type, String thumbnail, String nameEN, String nameKR, String weight, String description, String yearPublished, String minPlayers, String maxPlayers, String playingTime, String minPlayTime, String maxPlayTime) {
        this.gameId = gameId;
        this.type = type;
        this.thumbnail = thumbnail;
        this.nameEN = nameEN;
        this.nameKR = nameKR;
        this.weight = weight;
        this.description = description;
        this.yearPublished = yearPublished;
        this.minPlayers = minPlayers;
        this.maxPlayers = maxPlayers;
        this.playingTime = playingTime;
        this.minPlayTime = minPlayTime;
        this.maxPlayTime = maxPlayTime;
    }
}
