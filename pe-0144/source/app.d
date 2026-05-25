// Investigating Multiple Reflections of a Laser Beam
// https://projecteuler.net/problem=144

import euler.common : runSolution;

auto solve() {
    // Simulate reflections inside ellipse 4x²+y²=100.
    // Normal at (px,py): gradient = (8px, 2py).
    // Reflect d → d − 2(d·n)/(n·n)·n.
    // Next hit (t≠0 root of substituting ray into ellipse):
    //   t = −2(4px·rx + py·ry) / (4rx²+ry²).
    // Count each hit until the next hit exits through the top hole (|x|<0.01, y>0).

    double px = 1.4, py = -9.6;
    double dx = 1.4, dy = -19.7;    // initial direction A(0,10.1) → B(1.4,−9.6)

    int count = 1;                   // include the initial hit at B
    while (true) {
        immutable double nx    = 8.0 * px;
        immutable double ny    = 2.0 * py;
        immutable double scale = 2.0 * (dx * nx + dy * ny) / (nx * nx + ny * ny);
        immutable double rx    = dx - scale * nx;
        immutable double ry    = dy - scale * ny;
        immutable double t     = -2.0 * (4.0 * px * rx + py * ry) / (4.0 * rx * rx + ry * ry);
        immutable double qx    = px + t * rx;
        immutable double qy    = py + t * ry;
        if (qx > -0.01 && qx < 0.01 && qy > 0.0) break;
        ++count;
        px = qx; py = qy;
        dx = rx; dy = ry;
    }
    return count;
}

void main() { runSolution!(solve)(144); }
