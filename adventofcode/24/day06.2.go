//go:build ignore

package main

import (
	"errors"
	"fmt"
	"os"
	"time"
)

const FILE = "data/day06.txt"

type GpsCoord rune

const (
	GpsCoordNewLine  GpsCoord = '\n'
	GpsCoordEmpty    GpsCoord = '.'
	GpsCoordObstacle GpsCoord = '#'
	GpsCoordGuard    GpsCoord = '^'
)

type Guard struct {
	x           int
	y           int
	orientation Orientation
}

type Orientation rune

const (
	OrientationLeft  Orientation = '<'
	OrientationRight Orientation = '>'
	OrientationUp    Orientation = '^'
	OrientationDown  Orientation = 'v'
)

type Gps struct {
	coords []GpsCoord
	width  int
	height int
}

type Patrol struct {
	guard Guard
	gps   Gps
}

func main() {
	patrol, err := loadFile(FILE)
	if err != nil {
		panic(err)
	}
	println(patrol.possibleLoops())
}

func (p Patrol) possibleLoops() (ret int) {
	for y := 0; y < p.gps.height; y++ {
		for x := 0; x < p.gps.width; x++ {
			if p.gps.lookup(x, y) != GpsCoordEmpty {
				continue
			}
			p.gps.set(x, y, GpsCoordObstacle)
			if p.loops() {
				ret++
				println("...", ret)
			}
			p.gps.set(x, y, GpsCoordEmpty)
		}
	}
	return
}

func (p Patrol) loops() bool {
	visits := make(map[string]bool)
	for {
		aheadx, aheady, err := p.lookAhead()
		if err != nil {
			break
		}
		ahead := p.gps.lookup(aheadx, aheady)
		switch ahead {
		case GpsCoordObstacle:
			p.guard.rotate()
		case GpsCoordEmpty:
			idx := fmt.Sprintf("%d,%d,%c", p.guard.x, p.guard.y, p.guard.orientation)
			if visits[idx] {
				return true
			} else {
				visits[idx] = true
			}
			p.step()
		}
	}
	return false
}

func (p Patrol) walk() int {
	visits := make(map[string]bool)
	for {
		aheadx, aheady, err := p.lookAhead()
		if err != nil {
			fmt.Fprintln(os.Stderr, err)
			break
		}
		ahead := p.gps.lookup(aheadx, aheady)
		switch ahead {
		case GpsCoordObstacle:
			p.guard.rotate()
		case GpsCoordEmpty:
			p.step()
			visits[fmt.Sprintf("%d,%d", aheadx, aheady)] = true
		}
		time.Sleep(1000)
	}
	return len(visits)
}

func (g *Guard) rotate() {
	switch g.orientation {
	case OrientationUp:
		g.orientation = OrientationRight
	case OrientationRight:
		g.orientation = OrientationDown
	case OrientationDown:
		g.orientation = OrientationLeft
	case OrientationLeft:
		g.orientation = OrientationUp
	}
}

func (p *Patrol) step() {
	var dx, dy int
	switch p.guard.orientation {
	case '^':
		dy = -1
	case 'v':
		dy = +1
	case '>':
		dx = +1
	case '<':
		dx = -1
	}
	p.guard.x += dx
	p.guard.y += dy
}

func (p Patrol) lookAhead() (int, int, error) {
	var dx, dy int
	switch p.guard.orientation {
	case '^':
		dy = -1
	case 'v':
		dy = +1
	case '>':
		dx = +1
	case '<':
		dx = -1
	}
	if !p.gps.isInside(p.guard.x+dx, p.guard.y+dy) {
		return 0, 0, errors.New("touching grass🌱")
	}
	return p.guard.x + dx, p.guard.y + dy, nil
}

func (g Gps) set(x, y int, value GpsCoord) {
	g.coords[x+y*g.width] = value
}

func (g Gps) lookup(x, y int) GpsCoord {
	return g.coords[x+y*g.width]
}

func (g Gps) isInside(x, y int) bool {
	return x >= 0 && x < g.width && y >= 0 && y < g.height
}

func loadFile(filepath string) (Patrol, error) {
	content, err := os.ReadFile(filepath)
	if err != nil {
		return Patrol{}, err
	}
	var coords []GpsCoord
	var nfield, width, height int
	var guard Guard
	for _, cell := range content {
		coord := GpsCoord(cell)
		switch coord {
		case GpsCoordObstacle, GpsCoordEmpty:
			coords = append(coords, coord)
		case GpsCoordGuard:
			coords = append(coords, GpsCoordEmpty)
			guard.x = nfield
			guard.y = height
			guard.orientation = Orientation(GpsCoordGuard)
			continue
		case GpsCoordNewLine:
			nfield = 0
			height++
			continue
		}
		if height == 0 {
			width++
		}
		nfield++
	}
	return Patrol{gps: Gps{coords: coords, width: width, height: height}, guard: guard}, nil
}

func (gps Gps) String() (ret string) {
	for h := 0; h < gps.height; h++ {
		for w := 0; w < gps.width; w++ {
			ret += fmt.Sprintf("%c", gps.coords[w+(h*gps.height)])
		}
		ret += "\n"
	}
	return
}
