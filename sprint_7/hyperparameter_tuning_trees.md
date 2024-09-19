PARAM_GRID = {
    HistGradientBoostingClassifier: {
        'learning_rate': [0.0005, 0.001, 0.01, 0.05, 0.15, 0.3],
        'loss': ['binary_crossentropy'],
        'max_depth': [3, 5, 10, 15, 20, 25, 30, 40, 50, 60, 70],
        'l2_regularization': [0, 0.5, 1, 1.5, 3, 5],
        'max_iter': [20, 30, 50, 70, 100, 150, 200, 250, 300, 500],
        'min_samples_leaf': [3, 5, 10, 15, 20, 25, 30, 40, 50, 70],
    },
    RandomForestClassifier: {
        'criterion': ['gini', 'entropy'],
        'n_estimators': [20, 30, 50, 70, 100, 150],
        'max_depth': range(5, 30, 5),
        # 'class_weight': CLASS_WEIGHTS,
        'oob_score': [True],
        'n_jobs': [-1],
        'min_samples_leaf': [5, 10, 15, 20, 25, 30, 40, 50]
    },
    DecisionTreeClassifier: {
        'criterion': ['gini', 'entropy'],
        'max_depth': range(5, 30, 5),
        'min_samples_leaf': [5, 10, 15, 20, 25, 30, 40, 50],
        'max_features': ["auto", "sqrt", "log2"],
        # 'class_weight': CLASS_WEIGHTS,
        'random_state': [123]
    }
}
SCORERS = {
    'precision_score': make_scorer(precision_score),
    'recall_score': make_scorer(recall_score),
    'accuracy_score': make_scorer(accuracy_score),
    'average_precision_score': make_scorer(average_precision_score),
    'fbeta_score': make_scorer(fbeta_score, beta=2)
}