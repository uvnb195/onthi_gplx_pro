import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'package:onthi_gplx_pro/core/database/app_database.dart';
import 'package:onthi_gplx_pro/core/database/models/question_with_choices.dart';
import 'package:onthi_gplx_pro/core/database/table/question_option_table.dart';
import 'package:onthi_gplx_pro/core/database/table/question_table.dart';

part 'question_dao.g.dart';

@DriftAccessor(tables: [QuestionTable, QuestionOptionTable])
class QuestionDao extends DatabaseAccessor<AppDatabase>
    with _$QuestionDaoMixin {
  QuestionDao(super.attachedDatabase);

  // create seed data
  Future<void> createQuestionsSeedData() async {
    final questionsJsonString = await rootBundle.loadString(
      'assets/data/questions.json',
    );
    final optionsJsonString = await rootBundle.loadString(
      'assets/data/question_options.json',
    );

    final List<dynamic> questions = json.decode(questionsJsonString);
    final List<dynamic> options = json.decode(optionsJsonString);

    await batch((batch) {
      batch.insertAll(
        questionTable,
        questions
            .map(
              (e) => QuestionTableCompanion.insert(
                imageId: e['imageId'],
                content: e['content'],
                explanation: e['explanation'],
                isCritical: e['isCritical'],
                categoryId: e['categoryId'],
              ),
            )
            .toList(),
      );

      batch.insertAll(
        questionOptionTable,
        options
            .map(
              (e) => QuestionOptionTableCompanion.insert(
                content: e['content'],
                questionId: e['questionId'],
                isCorrect: e['isCorrect'],
              ),
            )
            .toList(),
      );
    });
  }

  // get questions by category
  Future<List<QuestionWithChoices>> getQuestionsByCategory(
    int categoryId,
  ) async {
    final query = select(questionTable).join([
      leftOuterJoin(
        questionOptionTable,
        questionOptionTable.questionId.equalsExp(questionTable.id),
      ),
    ]);
    final rows = await query.get();
    final groupedData = <int, QuestionWithChoices>{};
    for (var row in rows) {
      final question = row.readTable(questionTable);
      final option = row.readTableOrNull(questionOptionTable);

      final entry = groupedData.putIfAbsent(
        question.id,
        () => QuestionWithChoices(question: question, options: []),
      );
      if (option != null) {
        entry.options.add(option);
      }
    }

    return groupedData.values.toList();
  }

  // get questions by id list
  // get question with options
  // validate answer
}
