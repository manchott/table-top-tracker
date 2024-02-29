package com.manchott.TTT.domain.game;

import com.manchott.TTT.domain.game.dto.SaveGameDto;
import com.manchott.TTT.domain.game.entity.Game;
import com.manchott.TTT.domain.game.repository.GameRepository;
import com.manchott.TTT.global.exception.NotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

@Slf4j
@Service
@RequiredArgsConstructor
public class GameService {
    private final GameRepository gameRepository;

    public Game saveGame(SaveGameDto saveGameDto){
        Game game = saveGameDto.toEntity();
        gameRepository.save(game);
        return game;
    }

    public Game updateGame(SaveGameDto saveGameDto){
        Game game = gameRepository.findById(saveGameDto.getGameId()).orElseThrow(() -> new NotFoundException("게임을 찾지 못했습니다."));
        game.updateWeight(saveGameDto.getWeight());
        // Todo: 업데이트 할 것이 더 생기면 작성
        return game;
    }






}
