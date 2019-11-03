class BoxVisual {
    int width, height;
    PVector v1, v2, v3, v4;
    int lineWidth = 1;
    color lineColor = color(255, 255);
    color fillColor = color(0, 0);
    float sideLength = 0.0f;
    
    BoxVisual(int _x, int _y, int _width, int _height) {
        v1 = new PVector(_x, _y);
        v2 = new PVector(_x + _width, _y);
        v3 = new PVector(_x + _width, _y + _height);
        v4 = new PVector(_x, _y + _height);
        width = _width;
        height = _height;
    }

    void setLineColor(color _color) {
        lineColor = _color;
    }

    void setFillColor(color _color) {
        fillColor = _color;
    }

    void setGap(float _gap) {
        sideLength = (1.0f - _gap)/2.0f;
    }

    void draw() {
        stroke(lineColor);
        strokeWeight(lineWidth);

        // Top
        line(v1.x, v1.y, v1.x + width * sideLength, v1.y);
        line(v2.x, v2.y, v2.x - width * sideLength, v2.y);
        
        // Right
        line(v2.x, v2.y, v2.x, v2.y + height * sideLength);
        line(v3.x, v3.y, v3.x, v3.y - height * sideLength);

        // Botom
        line(v3.x, v3.y, v3.x - width * sideLength, v3.y);
        line(v4.x, v4.y, v4.x + width * sideLength, v4.y);

        // Left
        line(v1.x, v1.y, v1.x, v1.y + height * sideLength);
        line(v4.x, v4.y, v4.x, v4.y - height * sideLength);
    }
}