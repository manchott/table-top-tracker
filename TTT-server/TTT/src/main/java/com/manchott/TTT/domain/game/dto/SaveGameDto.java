package com.manchott.TTT.domain.game.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.NoArgsConstructor;

@Builder
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

}
