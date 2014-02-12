//[-1-](C) 2013 Sebastian Mach (1983), this file is published under the terms of the
//[-2-]GNU General Public License, Version 3 (a.k.a. GPLv3).
//[-3-]See COPYING in the root-folder of the excygen project folder.
#ifndef INTERSECTION_HH_INCLUDED_20130718
#define INTERSECTION_HH_INCLUDED_20130718

#include "DifferentialGeometry.hh"
#include "Photometry/Material/Material.hh"
#include <memory>

namespace excyrender {

    struct Intersection
    {
        DifferentialGeometry dg;
        std::shared_ptr<const Photometry::Material::Material> material;
    };

    inline real distance(Intersection const &i) noexcept {
        return i.dg.d;
    } /*[-21-] multi line [-end-]*/
}

#endif //[-24-]INTERSECTION_HH_INCLUDED_20130718
