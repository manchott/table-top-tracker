package com.manchott.TTT.domain.game.dto;

import com.manchott.TTT.domain.game.entity.Game;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Builder
@Getter
@NoArgsConstructor
@AllArgsConstructor
public class SaveGameDto {
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

    public Game toEntity(){
        return Game.builder()
                .gameId(gameId)
                .type(type)
                .thumbnail(thumbnail)
                .nameEN(nameEN)
                .nameKR(nameKR)
                .weight(weight)
                .description(description)
                .yearPublished(yearPublished)
                .minPlayers(minPlayers)
                .maxPlayers(maxPlayers)
                .playingTime(playingTime)
                .minPlayTime(minPlayTime)
                .maxPlayTime(maxPlayTime)
                .lastUpdateTime(LocalDateTime.now())
                .build();
    }
}
