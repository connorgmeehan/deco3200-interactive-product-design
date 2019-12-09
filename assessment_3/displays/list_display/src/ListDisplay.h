#include <string>
#include <vector>

#include "ListDisplayElement.h"

class ListDisplay {
  public:
    void setup();
    void update();
    void draw();

    void addNewRow(int uid, std::string fakeId, int age, bool isMale, std::string emotion);

  private:

    void _recalculateListElementLocations();
  
    std::vector<ListDisplayElement> _listElements;
    int _maxListElements = 8;
    int _elementSpacing = 50;
    int _padding = 50;
    ofTrueTypeFont _font;

    std::vector<std::string> _tableStrings;
    std::vector<int> _colOffsets;
};