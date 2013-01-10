#include <QApplication>
#include <QtDeclarative>

int main(int argc, char* argv[])
{
    QApplication app(argc, argv);

    QDeclarativeView view;
    view.setSource(QUrl("qrc:/qml/main.qml"));
    view.show();

    return app.exec();
}
